From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [driver-core PATCH v5 5/9] driver core: Establish clear order of
 operations for deferred probe and remove
Date: Fri, 23 Nov 2018 06:19:53 -0800
Message-ID: <f9ccdf33-6b7a-cdb2-150b-3ab83892c96e@acm.org>
References: <154145232484.29224.1635232599636954462.stgit@ahduyck-desk1.jf.intel.com>
 <201811061228.iteFLO2p%fengguang.wu@intel.com>
 <1541548274.196084.197.camel@acm.org>
 <d70f2bcb-0e1c-2d69-2692-329ef5cf81bc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d70f2bcb-0e1c-2d69-2692-329ef5cf81bc@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rong Chen <rong.a.chen@intel.com>, kbuild test robot <lkp@intel.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, linux-nvdimm@lists.01.org, tj@kernel.org, akpm@linux-foundation.org, linux-pm@vger.kernel.org, jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com, dave.jiang@intel.com
List-Id: linux-pm@vger.kernel.org

On 11/22/18 5:23 PM, Rong Chen wrote:
> Kbuild robot printed all warnings and the below warning was found in 
> patch 5/9.
> 
> "include/linux/device.h:1056: warning: Function parameter or member 
> 'async_probe' not described in 'device'"

Hi Rong,

Thanks for having taken a look. That's indeed something that must be 
fixed in patch 5/9.

Bart.
