From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 0/2] PM / devfreq: Use the resource-managed function for
 devfreq device
Date: Wed, 26 Oct 2016 16:35:48 +0900
Message-ID: <1477467350-27059-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch just uses the resource-managed function when adding the new devfreq
deivce. This function handles the memory and delete of devfreq instance
automatically.

Chanwoo Choi (2):
  PM / devfreq: rk3399_dmc: Use the resource-managed function to add devfreq dev
  scsi: ufs: Use the resource-managed function to add devfreq device

 drivers/devfreq/rk3399_dmc.c | 2 +-
 drivers/scsi/ufs/ufshcd.c    | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

-- 
1.9.1
