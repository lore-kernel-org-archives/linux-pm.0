From: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Subject: Re: Building ACPI for PPC architecture
Date: Mon, 23 Oct 2006 14:36:19 +0400
Message-ID: <453C9B23.4020706@linux.intel.com>
References: <200610230655.MAA16239@WS0005.indiatimes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200610230655.MAA16239@WS0005.indiatimes.com>
Sender: linux-acpi-owner@vger.kernel.org
To: rajeshprabhu72721 <rajeshprabhu72721@indiatimes.com>
Cc: linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

You should try to build ACPI CA interpreter in user-space for your architecture first.
Get it here: http://www.intel.com/technology/iapc/acpi/downloads.htm
There is a big chance that you will find too many endian issues.

Regards,
	Alex.

rajeshprabhu72721 wrote:
> 
> We are trying to build ACPI for PPC e300 core . The problem is we donot have a BIOS running to supply the System Descriptor Tables to ACPI during boot. So ACPI gets disabled during boot. Are the system desc tables must for the ACPI to run? Or is there a method where we can avoid these tables and make ACPI work directly. Without BIOS how do we make ACPI up and running?
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> Have you checked out the new-look www.indiatimes.com yet?Have you checked out the new-look www.indiatimes.com yet?
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
