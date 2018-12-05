From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] cpupower : Auto-completion for cpupower tool
Date: Wed, 05 Dec 2018 12:48:53 +0100
Message-ID: <2133486.u21R1XiQqC@house>
References: <20181205113104.71319-1-huntbag@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205113104.71319-1-huntbag@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Cc: linux-pm@vger.kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com, Bharath Thodla <bharath.thodla@in.ibm.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, December 5, 2018 12:31:04 PM CET Abhishek Goel wrote:
> This script adds support for auto-completion for cpupower tool.
> Added support for auto-completion of all the eight commands for
> cpupower tool and their all subsequent sub-commands, wherever
> possible.

>From what I see all changes I proposed in a previous review round
with a "not that broad audience" have been addressed.

I already integrated the patch (slightly different, without functional 
changes) into the latest cpupower sources of our build service and
things work out nice.

Shuah: Can you pick this up for next cpupower submission round, please.

Thanks,

       Thomas
