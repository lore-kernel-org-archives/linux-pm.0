From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [driver-core PATCH v6 6/9] driver core: Probe devices
 asynchronously instead of the driver
Date: Thu, 08 Nov 2018 15:59:46 -0800
Message-ID: <1541721586.196084.241.camel@acm.org>
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
         <154170043123.12967.3591757325647337726.stgit@ahduyck-desk1.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-7"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <154170043123.12967.3591757325647337726.stgit@ahduyck-desk1.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc: linux-nvdimm@lists.01.org, tj@kernel.org, akpm@linux-foundation.org, linux-pm@vger.kernel.org, jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com, dave.jiang@intel.com
List-Id: linux-pm@vger.kernel.org

On Thu, 2018-11-08 at 10:07 -0800, Alexander Duyck wrote:
+AD4 Probe devices asynchronously instead of the driver. This results in us
+AD4 seeing the same behavior if the device is registered before the driver or
+AD4 after. This way we can avoid serializing the initialization should the
+AD4 driver not be loaded until after the devices have already been added.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
