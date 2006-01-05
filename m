From: "Preece Scott-PREECE" <scott.preece@motorola.com>
Subject: RE: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface
Date: Thu, 5 Jan 2006 17:13:37 -0500
Message-ID: <ADE4D9DBCFC3A345AAA95C195F62B6DDD3AD54@de01exm64.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751582AbWAEWNo@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: pavel@suse.cz, akpm@osdl.org, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

User space has no particular reason to know which state of a particular
device corresponds to the logical state "on" or "off" or whatever other
states might be needed. Once you've defined the set of standard, generic
states, then the device driver writer can figure out which device state
matches the requirements for a given generic state.

While I wouldn't hate putting this in a system-level configuration file,
I really think it's device-specific stuff that should be built-in.

scott

-----Original Message-----
From: Patrick Mochel [mailto:mochel@digitalimplant.org] 
Sent: Thursday, January 05, 2006 3:48 PM
To: Preece Scott-PREECE
Cc: pavel@suse.cz; ; ; 
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys
interface


On Thu, 5 Jan 2006, Scott E. Preece wrote:

> --===============26103097005026354==
>
>
> My inclination would be to have the sysfs interface know generic 
> terms, with the implementation mapping them to device-specific terms. 
> It ought to be possible to build portable tools that don't have to 
> know about device-specific states and have the device interfaces (in 
> sysfs) do the necessary translation.

Userspace should do the translation. You should give the user the
ability to specify simple, meaningful states, like "on" and "off". But,
it should be the tools itself that are mapping those requests to valid
input for the sysfs files.

Why force the translation into the kernel, and provide more
opportunities for error in parsing the sysfs files? Do it in userspace,
and you can afford much more flexibility and portability.

Thanks,


	Patrick
