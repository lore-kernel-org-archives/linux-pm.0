From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [PATCH] ACPI, cpuidle: Fix suspend/resume regression caused by
 cpuidle cleanup.
Date: Wed, 13 Jun 2012 10:25:12 -0700
Message-ID: <4FD8CCF8.1000607@linux.vnet.ibm.com>
References: <4FD87249.6010302@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <4FD87249.6010302@linux.vnet.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>, linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Jean Pihet <j-pihet@ti.com>, Arjan van de Ven <arjan@linux.intel.com>, Kevin Hilman <khilman@ti.com>, Arnd Bergmann <arnd@arndb.de>, Ferenc Wagner <wferi@niif.hu>, "Tomas M." <tmezzadra@gmail.com>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, preeti@linux.vnet.ibm.com
List-Id: linux-pm@vger.kernel.org

On 06/13/2012 03:58 AM, Deepthi Dharwar wrote:
> In addition to the above fix, a sanity check has also been added
> in x86 arch specific cpu_idle call to ensure that the idle call
> always returns with IRQs enabled.
> 
> This patch applies on 3.5-rc2

Just applied this on top of a post-3.5-rc2 kernel (7794f70).
Suspend/resume seems to work just fine on the hardware where it was
broken.  Thanks, Deepthi!

My tested-by was for the original hackish patch, but this is just to
spell out that it worked for me with this patch too.

Tested-by: Dave Hansen <dave@linux.vnet.ibm.com>

