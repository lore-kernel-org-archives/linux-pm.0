From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Subject: 4.14.0-rc7: cpufreq interface in sysfs removed ?
Date: Wed, 1 Nov 2017 18:06:53 +0100
Message-ID: <CADDKRnDjXzSU=toFVH6pYOS9co4rp-hQ8rv6U9zBnChj_bLAvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:47312 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751428AbdKARGz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Nov 2017 13:06:55 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>

In 4.14.0-rc7-00009-g287683d cpufreq directory under
/sys/devices/system/cpu/cpufreq
is empty. Also link /sys/devices/system/cpu/cpu0/cpufreq is missing.

Is this change intentional?

J=C3=B6rg
