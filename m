From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: very slow IO after resume
Date: Thu, 02 Jan 2014 12:33:14 +0100
Message-ID: <52C54E7A.3030303@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:63988 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbaABLdS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jan 2014 06:33:18 -0500
Received: by mail-we0-f173.google.com with SMTP id u57so12218433wes.4
        for <linux-pm@vger.kernel.org>; Thu, 02 Jan 2014 03:33:17 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM mailing list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


Hi All,

I noticed an issue on the IOs after resuming my laptop.

My mailer thunderbird or the compilations are very slow, often blocked=20
in 'D' state. The 'top' shows 81% on wait.

The processes stack are always in when blocked:

[<c164f8ab>] balance_dirty_pages.isra.18+0x3f5/0x4b4
[<c112a2ce>] balance_dirty_pages_ratelimited+0xde/0x100
[<c1120d81>] generic_perform_write+0x141/0x1c0
[<c1120e50>] generic_file_buffered_write+0x50/0x80
[<c1122a4a>] __generic_file_aio_write+0x22a/0x490
[<c1122d13>] generic_file_aio_write+0x63/0xd0
[<c11f5162>] ext4_file_write+0xb2/0x100
[<c117318a>] do_sync_write+0x6a/0xa0
[<c1173dc5>] vfs_write+0xa5/0x1d0
[<c1174277>] SyS_write+0x57/0xa0
[<c1661b37>] syscall_call+0x7/0xb

The kernel is 3.11.0-031100-generic based on ubuntu, I noticed this=20
issue on some previous version (since 3.5 AFAIR).
My laptop is a Lenovo X230, SSD 250GB (6Gb/s) and 16GB of RAM.

Is it a known issue ?

Thanks
-- Daniel

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

