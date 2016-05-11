From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2, 0/3] intel_pstate: Improvements related to the APERF/MPERF computation
Date: Wed, 11 May 2016 19:06:55 +0200
Message-ID: <4400018.TlI4RAhtYU@vostro.rjw.lan>
References: <2638272.Bq3MnQEe4U@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2638272.Bq3MnQEe4U@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, May 07, 2016 01:42:53 AM Rafael J. Wysocki wrote:
> Hi,
> 
> As per the subject, on top of the current linux-next branch of linux-pm.git.

This version has been reworked to retain more APERF bits after carrying out the
\Delta_{APERF}/\Delta_{MPERF} which should lead to a bit more precise numbers
in sysfs etc.

Thanks,
Rafael
