From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [discuss]disable PCI resource decode in D3?
Date: Wed, 24 Oct 2007 22:57:43 +0200
Message-ID: <200710242257.43742.rjw@sisk.pl>
References: <1193194720.27150.27.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1193194720.27150.27.camel@sli10-conroe.sh.intel.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, 24 October 2007 04:58, Shaohua Li wrote:
> PCIPM spec requires OS to disable IO/Memory decode and bus master if a
> device is put into D3 (spec 8.2.2). pci_set_power_state doesn't do this
> for D3. Could this cause mysterious hang of S3 in some BIOS?

In principle, it could.

In practice, it would be nice to ask someone who works on actual hardware/BIOS.

Greetings,
Rafael
