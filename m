From: Michael-Luke Jones <mlj28@cam.ac.uk>
Subject: Re: [RFC][PATCH -mm 3/3] PM: Disable _request_firmware
	before hibernation/suspend
Date: Mon, 28 May 2007 14:10:52 +0100
Message-ID: <A19B5FA5-0DF4-4B8D-957C-3D6FB3485C30@cam.ac.uk>
References: <200705272229.21263.rjw@sisk.pl>
	<20070527220412.GC22687@srcf.ucam.org>
	<1180304166.3131.66.camel@lov.localdomain>
	<200705280943.54312.rjw@sisk.pl>
	<20070528111554.GF18807@elf.ucw.cz>
	<1180351493.4242.31.camel@lov.localdomain>
	<6BFA837E-47D4-487F-9D71-FA83D6D865E5@cam.ac.uk>
	<1180353095.4242.57.camel@lov.localdomain>
	<BDEF3C8A-D237-44C4-84E0-2218DFAE0E77@cam.ac.uk>
	<20070528130030.GJ18807@elf.ucw.cz>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070528130030.GJ18807@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Kay Sievers <kay.sievers@vrfy.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 28 May 2007, at 14:00, Pavel Machek wrote:

> I'm too lazy to figure out how it currently works, but
> I'll just state it is not my fault

Figuring out how a userspace/kernelspace interface works should not  
rely on having to read kernelspace code. Unfortunately, in the case  
of hotplug / uevents, there is no such documentation. Thus, what  
kernelspace / userspace interactions actually are and what they  
should be is unclear, leading to confusion over corner cases, such as  
this one.

Michael-Luke Jones
