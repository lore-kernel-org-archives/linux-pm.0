From: Gabor Gombas <gombasg@sztaki.hu>
Subject: Re: [linux-pm] Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Date: Thu, 9 Feb 2006 09:53:44 +0100
Message-ID: <20060209085344.GF16052@boogie.lpds.sztaki.hu>
References: <20060208125753.GA25562@srcf.ucam.org> <20060208130422.GB25659@srcf.ucam.org> <20060208165803.GA15239@kroah.com> <20060208170857.GA29818@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060208170857.GA29818@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Greg KH <greg@kroah.com>, linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 08, 2006 at 05:08:58PM +0000, Matthew Garrett wrote:

> The backlight interface only supports exporting and setting the current 
> brightness. For various bits of hardware, the AC and DC brightnesses are 
> stored separately. Drivers would need to know which brightness value to 
> export to userspace. I have an HP backlight driver here which would 
> benefit from this, and I'm looking at the same issue for a Panasonic 
> one.

I don't know the backlight interface but extending it to export all
available brightness values would seem more logical to me.

If I'd had a laptop I'd hate if I could only set the DC brightness if I
plug out the AC power.

Gabor

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences
     ---------------------------------------------------------
