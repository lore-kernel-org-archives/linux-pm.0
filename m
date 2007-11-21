From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [PATCH 1/2] Freezer: Fix s2disk resume from initrd
Date: Wed, 21 Nov 2007 13:22:48 +1100
Message-ID: <200711211322.50103.nigel@nigel.suspend2.net>
References: <200711210244.37965.rjw@sisk.pl> <200711210250.18077.rjw@sisk.pl>
Reply-To: nigel@suspend2.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711210250.18077.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Chris Friedhoff <chris@friedhoff.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

Hi.

Just a typo...

On Wednesday 21 November 2007 12:50:17 Rafael J. Wysocki wrote:

> +	/*
> +	 * In case that a resume from disk is carreid out by linuxrc or one of

carried

> +	 * its children, we need to tell the freezer not to wait for us

(final full stop also missing)

Regards,

Nigel
-- 
See http://www.tuxonice.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.
