From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] kbuild: revert $(realpath ...) to $(shell cd ... && /bin/pwd)
Date: Mon,  2 Oct 2017 17:07:28 +0900
Message-ID: <1506931648-15511-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kbuild-owner@vger.kernel.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org
Cc: Julien Grall <julien.grall@arm.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-pm@vger.kernel.org, Michal Marek <mmarek@suse.com>, David Carrillo-Cisneros <davidcc@google.com>, linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-pm@vger.kernel.org

I thought commit 8e9b46679923 ("kbuild: use $(abspath ...) instead of
$(shell cd ... && /bin/pwd)") was a safe conversion, but it changed
the behavior.

$(abspath ...) / $(realpath ...) does not expand shell special
characters, such as '~'.

Here is a simple Makefile example:

  ---------------->8----------------
  $(info /bin/pwd: $(shell cd ~/; /bin/pwd))
  $(info abspath: $(abspath ~/))
  $(info realpath: $(realpath ~/))
  all:
          @:
  ---------------->8----------------

  $ make
  /bin/pwd: /home/masahiro
  abspath: /home/masahiro/workspace/~
  realpath:

This can be a real problem if 'make O=~/foo' is invoked from another
Makefile or primitive shell like dash.

This commit partially reverts 8e9b46679923.

Fixes: 8e9b46679923 ("kbuild: use $(abspath ...) instead of $(shell cd ... && /bin/pwd)")
Reported-by: Julien Grall <julien.grall@arm.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile                       | 4 ++--
 tools/power/cpupower/Makefile  | 2 +-
 tools/scripts/Makefile.include | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index cf007a3..1b48717 100644
--- a/Makefile
+++ b/Makefile
@@ -130,8 +130,8 @@ endif
 ifneq ($(KBUILD_OUTPUT),)
 # check that the output directory actually exists
 saved-output := $(KBUILD_OUTPUT)
-$(shell [ -d $(KBUILD_OUTPUT) ] || mkdir -p $(KBUILD_OUTPUT))
-KBUILD_OUTPUT := $(realpath $(KBUILD_OUTPUT))
+KBUILD_OUTPUT := $(shell mkdir -p $(KBUILD_OUTPUT) && cd $(KBUILD_OUTPUT) \
+								&& /bin/pwd)
 $(if $(KBUILD_OUTPUT),, \
      $(error failed to create output directory "$(saved-output)"))
 
diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 4c5a481..d6e1c02 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -26,7 +26,7 @@ endif
 
 ifneq ($(OUTPUT),)
 # check that the output directory actually exists
-OUTDIR := $(realpath $(OUTPUT))
+OUTDIR := $(shell cd $(OUTPUT) && /bin/pwd)
 $(if $(OUTDIR),, $(error output directory "$(OUTPUT)" does not exist))
 endif
 
diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 9dc8f07..1e8b611 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -1,7 +1,7 @@
 ifneq ($(O),)
 ifeq ($(origin O), command line)
-	ABSOLUTE_O := $(realpath $(O))
-	dummy := $(if $(ABSOLUTE_O),,$(error O=$(O) does not exist))
+	dummy := $(if $(shell test -d $(O) || echo $(O)),$(error O=$(O) does not exist),)
+	ABSOLUTE_O := $(shell cd $(O) ; pwd)
 	OUTPUT := $(ABSOLUTE_O)/$(if $(subdir),$(subdir)/)
 	COMMAND_O := O=$(ABSOLUTE_O)
 ifeq ($(objtree),)
@@ -12,7 +12,7 @@ endif
 
 # check that the output directory actually exists
 ifneq ($(OUTPUT),)
-OUTDIR := $(realpath $(OUTPUT))
+OUTDIR := $(shell cd $(OUTPUT) && /bin/pwd)
 $(if $(OUTDIR),, $(error output directory "$(OUTPUT)" does not exist))
 endif
 
-- 
2.7.4

