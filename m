From: "Moore, Robert" <robert.moore@intel.com>
Subject: Re: ACPI problem with ACER Aspire 3003LC laptop.
Date: Fri, 2 Jun 2006 12:10:32 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A4634DE4@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Yu, Luming" <luming.yu@intel.com>, rasmit.ranjan@wipro.com, linux-pm@osdl.org
Cc: linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

>Error: Looking uo[Z007]

This looks like the type of DSDT bug for which we recently implemented a workaround.


> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Yu, Luming
> Sent: Friday, June 02, 2006 5:11 AM
> To: rasmit.ranjan@wipro.com; linux-pm@osdl.org
> Cc: linux-acpi@vger.kernel.org
> Subject: RE: [linux-pm] ACPI problem with ACER Aspire 3003LC laptop.
> 
> Does latest base kernel work?
> If NOT, please file a bug on bugzilla.kernel.org
> 
> 
> Thanks
> Luming
> 
> ________________________________
> 
> 	From: linux-pm-bounces@lists.osdl.org [mailto:linux-pm-
> bounces@lists.osdl.org] On Behalf Of rasmit.ranjan@wipro.com
> 	Sent: 2006年6月2日 12:27
> 	To: linux-pm@osdl.org
> 	Subject: [linux-pm] ACPI problem with ACER Aspire 3003LC laptop.
> 
> 
> 	Hi all,
> 	    I am using ACER Aspire 3003LC laptop for developing a Host
> controller driver for kernel version 2.6.15.4.
> 	If i enable Power management support then my ethernet interface
> doesnot work. Also i get the message: " Disabling IRQ#3"
> 	This message comes from the kernel. And also i get following
> messages from ACPI:
> 
> 	    ACPI-0508: *** Error: Method execution failed[\_SB_.BAT1._BST]
> (Node cbd80560), AE_NOT_FOUND
> 	    ACPI-0339: *** Error: Looking uo[Z007] in namespace,
> AE_NOT_FOUND
> 
> 	I recompiled my kernel without power management support. Now my
> ethernet is working properly and obviously i don`t get any message from
> ACPI. This is the problem with the laptop. But I need Power management
> support. so is there any patch available for this ? Please suggest.
> 
> 	Thanks and regards,
> 	Rasmit.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
