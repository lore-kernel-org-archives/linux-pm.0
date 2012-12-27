From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: RE: [PATCH 0/6 v8] cpufreq: add support for Calxeda ECX-1000
 (highbank)
Date: Thu, 27 Dec 2012 08:28:22 -0500
Message-ID: <21672683C5A3814BB4DB938EBE482DE435D97660AB@IAD2MBX09.mex02.mlsrvr.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354726121-17190-1-git-send-email-mark.langsdorf@calxeda.com>,
 <2705062.NIaFfcLb3a@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <2705062.NIaFfcLb3a@vostro.rjw.lan>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

I thought I had addressed all the issues with the v9 version. The only comments I got on it was Mike's reviewed-by and I didn't think that warranted a resend.

If you do want me to send it again, do you want it  updated to current top-of-tree? That may take a bit, since there's an unrelated bug that's preventing my test box from booting.

--Mark Langsdorf
Calxeda, Inc.


________________________________________
From: Rafael J. Wysocki [rjw@sisk.pl]
Sent: Thursday, December 27, 2012 7:12 AM
To: Mark Langsdorf
Cc: linux-kernel@vger.kernel.org; cpufreq@vger.kernel.org; linux-pm@vger.kernel.org; linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/6 v8] cpufreq: add support for Calxeda ECX-1000 (highbank)

On Wednesday, December 05, 2012 10:48:35 AM Mark Langsdorf wrote:
> This patch series adds cpufreq support for the Calxeda
> ECX-1000 (highbank) SoCs. The EnergyCore Management Engine (ECME) on
> the ECX-1000 manages the voltage for the part and communications with
> Linux through a pl320 mailbox. clk notifications are used to control
> when to send messages to the ECME.

If you want me to handle this, can you please resend the whole patchset (with
all of the comments addressed, if possible)?

Rafael


--
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
