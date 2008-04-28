From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RESEND patch 2.6.25] ACPI uses device_may_wakeup()
	policy	inputs
Date: Mon, 28 Apr 2008 18:35:53 -0300
Message-ID: <20080428213553.GA3489__32483.9766406969$1209418670$gmane$org@khazad-dum.debian.net>
References: <200803201408.33466.david-b@pacbell.net>
	<200804182118.05228.david-b@pacbell.net>
	<1208871017.14474.52.camel@yakui_zhao.sh.intel.com>
	<200804261237.26499.david-b@pacbell.net>
	<1209386885.884.9.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1209386885.884.9.camel@yakui_zhao.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 28 Apr 2008, Zhao Yakui wrote:
> Yes. What your said is right. If your patch is applied, whether the PCI
> device can wake the sleeping system is controlled by device driver. In
> such case the /proc/acpi/wakeup will be useless.

Which calls for a new standard interface to let userpace control that,
doesn't it?  Issues with wake-up devices are not uncommon, the user
really has to have a way to configure that, and IMHO it better be a
generic one...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
