From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [driver-core PATCH v6 2/9] async: Add support for queueing on
 specific NUMA node
Date: Sun, 11 Nov 2018 13:24:21 -0800
Message-ID: <7373f722-f498-f0fa-2eaf-8ac9200fb9e1@acm.org>
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
 <154170041079.12967.13132220574997822111.stgit@ahduyck-desk1.jf.intel.com>
 <20181111193208.GB8332@kroah.com> <20181111195903.GA9726@amd>
 <20181111203304.GA16871@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181111203304.GA16871@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, tj@kernel.org, akpm@linux-foundation.org, linux-pm@vger.kernel.org, jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com, zwisler@kernel.org, dan.j.williams@intel.com, dave.jiang@intel.com
List-Id: linux-pm@vger.kernel.org

On 11/11/18 12:33 PM, Greg KH wrote:
> When I see new major patches show up from an Intel developer without
> _any_ other review from anyone else, directed at me, I get suspicious it
> is happening again.

Hi Greg,

Please note that I reviewed this patch four days ago. See also
https://lore.kernel.org/lkml/1541720197.196084.231.camel@acm.org/.

Thanks,

Bart.
