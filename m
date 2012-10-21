From: Maciej Rutecki <maciej.rutecki@gmail.com>
Subject: [REGRESSION] 3.7-rc2 kernel BUG at kernel/power/snapshot.c:517!
Date: Sun, 21 Oct 2012 17:12:28 +0200
Message-ID: <201210211712.28571.maciej.rutecki@gmail.com>
Reply-To: maciej.rutecki@gmail.com
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: lenb@kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org, pavel@ucw.cz, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Error: kernel BUG at kernel/power/snapshot.c:517!

Last known good: 3.6.1
Bad: 3.7-rc2

Steps to reproduce:
1. Boot system with 3.7-rc2 kernel
2. Try suspend to disk (s2ram works OK)

System dies on message:
http://mrutecki.pl/download/kernel/3.7-rc2/swinka/DSCN0280.jpg

lspci:
http://mrutecki.pl/download/kernel/3.7-rc2/swinka/lspci.txt

dmesg:
http://mrutecki.pl/download/kernel/3.7-rc2/swinka/dmesg-3.7-rc2.txt


-- 
Maciej Rutecki
http://www.mrutecki.pl
