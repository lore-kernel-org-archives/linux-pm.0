From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Urgent power management fix for v4.14
Date: Tue, 31 Oct 2017 00:24:27 +0100
Message-ID: <CAJZ5v0g989OhZOMr-_QYpaZjNaE1J+rrMpN1+Zp03q2t4YipAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-urgent-4.14

with top-most commit 2a9a86d5c81389cd9afe6a4fea42c585733cd705

 PM / QoS: Fix default runtime_pm device resume latency

on top of commit

 Linux 4.14-rc7

to receive an urgent power management fix for 4.14.

This fixes new breakage introduced by the most recent PM QoS
fix in which, embarrassingly enough, I forgot to update
dev_pm_qos_raw_read_value() to return the right default
for devices with no PM QoS constraints at all which prevents
runtime PM from suspending those devices (fix from Tero Kristo).

Thanks!

---------------

Tero Kristo (1):
      PM / QoS: Fix default runtime_pm device resume latency

---------------

 include/linux/pm_qos.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
