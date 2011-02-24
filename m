From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFT][PATCH] ACPI / ACPICA: Implicit notify for
	multiple	devices
Date: Thu, 24 Feb 2011 15:41:26 +0000
Message-ID: <20110224154126.GA5285__36831.3076709912$1298891713$gmane$org@srcf.ucam.org>
References: <201102232305.45005.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201102232305.45005.rjw@sisk.pl>
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
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, "Moore, Robert" <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>
List-Id: linux-pm@vger.kernel.org

Works on my test Thinkpad - notifies get sent to both EHCI controllers 
and the HDA hardware now.

Tested-by: Matthew Garrett <mjg@redhat.com>

-- 
Matthew Garrett | mjg59@srcf.ucam.org
