From: Jin Dongming <jin.dongming@np.css.fujitsu.com>
Subject: Re: [PATCH 4/8] ACPI: Use GPE reference counting to
 support shared GPEs
Date: Thu, 18 Feb 2010 16:05:07 +0900
Message-ID: <4B7CE6A3.7020103__34594.8536218659$1266476696$gmane$org@np.css.fujitsu.com>
References: <201002172335.47703.rjw@sisk.pl> <201002172341.07353.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002172341.07353.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg@redhat.com>, Linux PCI <linux-pci@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi, Rafael J. Wysocki
> -	/* Update enable mask, but don't enable the HW GPE as of yet */
> -
> -	status = acpi_ev_enable_gpe(gpe_event_info, FALSE);
I think the above line code should be remained. If it is deleted, the exception 
event will be raised on some machine.

Best Regards,
Jin Dongming
> -
>  	ACPI_DEBUG_PRINT((ACPI_DB_LOAD,
>  			  "Registered GPE method %s as GPE number 0x%.2X\n",
>  			  name, gpe_number));
> -	return_ACPI_STATUS(status);
> +	return_ACPI_STATUS(AE_OK);
>  }
>  
