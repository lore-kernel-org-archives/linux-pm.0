From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/2] suspend: Move NVS save/restore code
	to	generic suspend functionality
Date: Thu, 10 Jun 2010 15:09:11 +0100
Message-ID: <20100610140911.GA11193__45697.0363659368$1276179114$gmane$org@srcf.ucam.org>
References: <1275416390.3778.7.camel@maxim-laptop>
	<201006012331.59747.rjw@sisk.pl>
	<1275429125.5573.7.camel@maxim-laptop>
	<201006020040.22429.rjw@sisk.pl>
	<1275432410.6733.4.camel@maxim-laptop>
	<20100610135816.GG4514@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100610135816.GG4514@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 10, 2010 at 03:58:16PM +0200, Pavel Machek wrote:

> Well... should we only do it in 'platform' hibernation mode? There are
> machines that predate windows/acpi and still should hibernate.

If they predate acpi then they won't declare any NVS regions.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
