From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] debugfs_simple_attr.cocci: add clarifying information
Date: Fri, 30 Mar 2018 18:43:44 +0200
Message-ID: <1522428224-20192-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, Nicolai Stange <nstange@suse.de>, linux-pm@vger.kernel.org, yamada.masahiro@socionext.com
List-Id: linux-pm@vger.kernel.org

The referenced commit gives some information about the overhead
reduced by this change.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci b/scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
index 7c31231..6ff97e2 100644
--- a/scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
+++ b/scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
@@ -5,6 +5,8 @@
 //# Rationale: DEFINE_SIMPLE_ATTRIBUTE + debugfs_create_file()
 //# imposes some significant overhead as compared to
 //# DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_unsafe().
+//# See commit c64688081490 ("debugfs: add support for self-protecting
+//# attribute file fops") for further information.
 //
 // Copyright (C): 2016 Nicolai Stange
 // Options: --no-includes
