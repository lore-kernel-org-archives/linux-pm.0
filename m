From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 9/10] introduce intel_menlow platform
	specific driver
Date: Thu, 17 Jan 2008 09:18:24 +0100
Message-ID: <20080117081824.GA3284__17273.4913918704$1200557977$gmane$org@uranus.ravnborg.org>
References: <1200556278.2935.118.camel@acpi-sony.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1200556278.2935.118.camel@acpi-sony.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, sujith.thomas@intel.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

>  
> +config INTEL_MENLOW
> +        tristate "Thermal Management driver for Intel menlow platform"
> +        depends on ACPI_THERMAL
> +	default n

default n is not needed - it is default.

	Sam
