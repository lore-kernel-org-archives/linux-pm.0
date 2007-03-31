From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: Power Mangement Interfaces
Date: Sat, 31 Mar 2007 09:20:58 -0600
Message-ID: <20070331152058.GB8091@cosmic.amd.com>
References: <20070330235759.GC4252@cosmic.amd.com>
 <1175300283.23438.38.camel@johannes.berg>
 <1175300491.23438.40.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1175300491.23438.40.camel@johannes.berg>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.osdl.org, devel@laptop.org
List-Id: linux-pm@vger.kernel.org

On 31/03/07 02:21 +0200, Johannes Berg wrote:
> > > http://wiki.laptop.org/go/Power_Management_Interface
> 
> Hm, another thing. The RTC alarm wakeup event, wouldn't that require
> programming the time too? And if so, should that be done through the
> power interface to it?

Probably not - its pretty easy to set up the RTC alarm in your daemon
before going to STR - those interfaces exist and are well known.

The missing part is being able to configure the wakeup event correctly.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>


