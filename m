From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 1/2] suspend: Move NVS save/restore code to
 generic suspend functionality
Date: Fri, 11 Jun 2010 10:32:19 -0300
Message-ID: <20100611133219.GD28084__42039.743383839$1276264194$gmane$org@khazad-dum.debian.net>
References: <1275416390.3778.7.camel@maxim-laptop>
	<201006012331.59747.rjw@sisk.pl>
	<1275429125.5573.7.camel@maxim-laptop>
	<201006020040.22429.rjw@sisk.pl>
	<1275432410.6733.4.camel@maxim-laptop>
	<20100610135816.GG4514@ucw.cz>
	<20100610140911.GA11193@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100610140911.GA11193@srcf.ucam.org>
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
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 10 Jun 2010, Matthew Garrett wrote:
> On Thu, Jun 10, 2010 at 03:58:16PM +0200, Pavel Machek wrote:
> > Well... should we only do it in 'platform' hibernation mode? There are
> > machines that predate windows/acpi and still should hibernate.
> 
> If they predate acpi then they won't declare any NVS regions.

What if they're ACPI and APM capable, and in APM mode?  Would the code need
to guard against that?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
