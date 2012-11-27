From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: [PATCH 3/6 v6] cpufreq: tolerate inexact values when collecting stats
Date: Tue, 27 Nov 2012 14:04:29 -0600
Message-ID: <1354046672-7392-4-git-send-email-mark.langsdorf@calxeda.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354046672-7392-1-git-send-email-mark.langsdorf@calxeda.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1354046672-7392-1-git-send-email-mark.langsdorf@calxeda.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>
List-Id: linux-pm@vger.kernel.org

This patch is withdrawn due to a need for severe rework.

Changes from v4
        Withdrawn.      
Changes from v3, v2
        None.
Changes from v1
        Implemented a simple round-up algorithm instead of the over/under
method that could cause errors on Intel processors with boost mode.
