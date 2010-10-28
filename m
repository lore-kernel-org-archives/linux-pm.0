From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC/RFT][PATCH 0/3] ACPI: Fix handling of power
	resources during initialization
Date: Thu, 28 Oct 2010 15:07:34 +0200
Message-ID: <201010281507.34994.rjw__43751.9785752103$1288271737$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The following series of patches attempts to fix the problems with the handling
of power resources during initialization.

[1/3] allows power resource devices to be initialized by acpi_power driver as
      soon as they are found.

[2/3] creates power resource device objects as soon as they appear in the _PRn
      output for any devices.

[3/3] uses acpi_power_transition() to set up the initial reference counting of
      power resources as appropriate.

I have only tested them on machines without ACPI power resource objects, so all
this is kind of theoretical at the moment, but I think the patches are simple
enough.

Please test if you can and let me know what's wrong. :-)

Thanks,
Rafael
