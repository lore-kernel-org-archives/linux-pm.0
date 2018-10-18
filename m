From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [driver-core PATCH v4 4/6] driver core: Probe devices
 asynchronously instead of the driver
Date: Thu, 18 Oct 2018 13:13:56 -0700
Message-ID: <1539893636.81977.29.camel@acm.org>
References: <20181015150305.29520.86363.stgit@localhost.localdomain>
         <20181015150926.29520.45280.stgit@localhost.localdomain>
         <1539886275.81977.17.camel@acm.org>
         <e870da1d-48fa-7f2e-6909-b168a06633f2@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-7"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e870da1d-48fa-7f2e-6909-b168a06633f2@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Duyck <alexander.h.duyck@linux.intel.com>, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc: len.brown@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org, jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org, tj@kernel.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2018-10-18 at 12:38 -0700, Alexander Duyck wrote:
+AD4 Basically if somebody loads a driver the dev-+AD4-driver becomes set. If a 
+AD4 driver is removed it will clear dev-+AD4-driver and set driver+AF8-data to 
+AD4 0/NULL. That is what I am using as a mutex to track it in conjunction 
+AD4 with the device mutex. Basically if somebody attempts to attach a driver 
+AD4 before we get there we just exit and don't attempt to load this driver.

I don't think that the above matches your code. +AF8AXw-device+AF8-attach() does not
set the dev-+AD4-driver pointer before scheduling an asynchronous probe. Only
dev-+AD4-driver+AF8-data gets set before the asynchonous probe is scheduled. Since
driver+AF8-detach() only iterates over devices that are in the per-driver klist
it will skip all devices for which an asynchronous probe has been scheduled
but +AF8AXw-device+AF8-attach+AF8-async+AF8-helper() has not yet been called. My conclusion
remains that this patch does not prevent a driver pointer to become invalid
concurrently with +AF8AXw-device+AF8-attach+AF8-async+AF8-helper() dereferencing the same
driver pointer.

Bart.
