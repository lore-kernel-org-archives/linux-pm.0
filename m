From: Christoph Hellwig <hch@infradead.org>
Subject: Re: RFC: WMI Enhancements
Date: Thu, 20 Apr 2017 07:17:07 -0700
Message-ID: <20170420141707.GA22057@infradead.org>
References: <20170412230854.GA11963@fury>
 <20170419075248.GD18887@pali>
 <f3684c95b91349d3b4e512370ac1faf4@ausx13mpc120.AMER.DELL.COM>
 <201704191854.51783@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201704191854.51783@pali>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Mario.Limonciello@dell.com, dvhart@infradead.org, rjw@rjwysocki.net, luto@amacapital.net, len.brown@intel.com, corentin.chary@gmail.com, luto@kernel.org, andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

With Andy's conversion of WMI to the driver model the GUIDs should
be our device ids.  Which means WMI can support the dynamic device
ID model, where you can echo a id to sysfs to bind an id - that way
people could add the GUIDs on demand to the pass through driver if
they need them even with the whitelist approach.
