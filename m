From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 6/10] ACPI: register ACPI Video LCD as
	generic thermal cooling device
Date: Fri, 18 Jan 2008 01:42:54 +0000
Message-ID: <20080118014254.GA14818__48650.0478968539$1200620674$gmane$org@srcf.ucam.org>
References: <1200556282.2935.122.camel@acpi-sony.sh.intel.com>
	<20080117122431.GA32133@srcf.ucam.org>
	<1200619900.2935.161.camel@acpi-sony.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1200619900.2935.161.camel@acpi-sony.sh.intel.com>
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
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, "Thomas,
	Sujith" <sujith.thomas@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 18, 2008 at 09:31:40AM +0800, Zhang Rui wrote:

> Just like I don't think lcd should be used for ACPI thermal management
> before I saw it is listed in _TZD and intel_menlow requires to throttle
> it when overheating, why not let the individual drivers implement the
> callbacks if there is clearly a request to do this.
> And we can add this to the generic acpi_device struct then if this is a
> common feature for all ACPI devices.

It'll probably never be common for all ACPI devices, but it's already 
required for three types. I think that's a strong argument for making it 
generic.

> Well, you're right.
> But in order to throttle the lcd, this is reasonable, right?

Moving the common code into its own routine and then calling that from 
each of the others would probably work.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
