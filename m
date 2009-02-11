From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Tue, 10 Feb 2009 20:47:36 -0800
Message-ID: <20090211044736.GB9980@bulgaria.corp.google.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<1233802226-23386-2-git-send-email-arve@android.com>
	<20090205225158.GA19577@linux.intel.com>
	<d6200be20902051613k77ef5878v7734653749ead8a@mail.gmail.com>
	<20090210202507.GE1382@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090210202507.GE1382@ucw.cz>
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
Cc: ncunningham@crca.org.au, u.luckas@road.de, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

[Pavel Machek <pavel@ucw.cz>]
> > 
> > wake_lock never blocks.
> 
> Wakelock is really bad name: it is not a lock and it does not protect
> wake. I'd say we need better name here.

I agree with you here -- I've had this discussion with Arve previously,
but have been unable to offer a compelling alternative name.  Anybody
have a good idea?

Some people use "sleep vote" for a similar mechanism (though usually
you're voting against sleep, which makes it feel backwards to me).

Brian
