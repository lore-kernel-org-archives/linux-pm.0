From: malattia@linux.it
Subject: [PATCH 0/3] Minor fixes for tools/cpupower
Date: Wed, 16 Mar 2016 07:13:05 -0700
Message-ID: <1458137588-6126-1-git-send-email-malattia@linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34039 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966415AbcCPONT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 10:13:19 -0400
Received: by mail-pf0-f171.google.com with SMTP id x3so76748702pfb.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2016 07:13:19 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.com>
Cc: linux-pm@vger.kernel.org, Mattia Dongili <malattia@linux.it>

=46rom: Mattia Dongili <malattia@linux.it>

Hi Thomas,

here's a handful of patches that I'm applying for the Debian packaging =
of
cpupower.
Nothing major like you'll see below, let me know if you want me to chan=
ge
anything.

Thanks!

Mattia Dongili (3):
  warning: comparison of constant =E2=80=98-1=E2=80=99 with boolean exp=
ression is always
    false
  Fix cpupower manpages "NAME" section
  Honour user's LDFLAGS

 tools/power/cpupower/bench/Makefile                | 2 +-
 tools/power/cpupower/man/cpupower-frequency-info.1 | 2 +-
 tools/power/cpupower/man/cpupower-frequency-set.1  | 2 +-
 tools/power/cpupower/man/cpupower-idle-info.1      | 2 +-
 tools/power/cpupower/man/cpupower-idle-set.1       | 2 +-
 tools/power/cpupower/utils/helpers/topology.c      | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

--=20
2.7.0

