From: Thomas Renninger <trenn@suse.de>
Subject: Re: Fail to build tools/all
Date: Mon, 02 May 2016 12:20:08 +0200
Message-ID: <1585171.cPeXrju8v9@skinner>
References: <20160501050629.GA7386@linux-dunz.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58293 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753044AbcEBKUK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 May 2016 06:20:10 -0400
In-Reply-To: <20160501050629.GA7386@linux-dunz.site>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sean Fu <fxinrong@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Sunday, May 01, 2016 01:11:33 PM Sean Fu wrote:
> Hi guys:
>         I encountered a build error when running "make V=1 tools/all".
>         Shall we write a patch to fix it?

This is not a bug.

>         The following is error log.
> 
> ================================ start ==========================
> commit 05cf8077e54b20dddb756eaa26f3aeb5c38dd3cf
> Merge: cf78031 db5dd0d
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Fri Apr 1 20:03:33 2016 -0500
> ================================= end  =========================
> 
> ============================== start ===========================
> mkdir -p
> /home/sean/work/source/upstream/kernel.linus/linux/tools/power/cpupower
> && make O=/home/sean/work/source/upstream/kernel.linus/linux
> subdir=tools/power/cpupower --no-print-directory -C power/cpupower
> gcc  -DVERSION=\"4.6.rc1.190.g05cf80\" -DPACKAGE=\"cpupower\"
> -DPACKAGE_BUGREPORT=\"linux-pm@vger.kernel.org\" -D_GNU_SOURCE -pipe
> -DNLS -Wall -Wchar-subscripts -Wpointer-arith -Wsign-compare
> -Wno-pointer-sign -Wdeclaration-after-statement -Wshadow -O1 -g -DDEBUG
> -I./lib -I ./utils -o
> /home/sean/work/source/upstream/kernel.linus/linux/utils/helpers/amd.o
> -c utils/helpers/amd.c
> utils/helpers/amd.c:7:21: fatal error: pci/pci.h: No such file or
> directory
>  #include <pci/pci.h>

You need pciutils header and library:
ftp://ftp.kernel.org/pub/software/utils/pciutils

        Thomas
