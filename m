From: Kyle Moffett <kyle@moffetthome.net>
Subject: Re: [RFD] Automatic suspend
Date: Mon, 16 Feb 2009 15:08:09 -0500
Message-ID: <f73f7ab80902161208h12837d4ex1d28d55d031d5d71__18828.4369455234$1234823429$gmane$org@mail.gmail.com>
References: <200902160010.16955.rjw@sisk.pl>
	<200902160806.17901.oliver@neukum.org>
	<20090216074048.6d70f17c@infradead.org>
	<200902161748.09208.oliver@neukum.org>
	<20090216093108.078aac35@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090216093108.078aac35@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 16, 2009 at 12:31 PM, Arjan van de Ven <arjan@infradead.org> wrote:
> On Mon, 16 Feb 2009 17:48:06 +0100 Oliver Neukum <oliver@neukum.org> wrote:
>> Should there be a channel through which drivers can tell user space
>> what the consequences in terms of reaching a sleep state are if a
>> service is requested?
>
> Personally, I don't think so.
> Think about it: what would userspace do?
> Not ask for the functionality if it means no sleep state?
> Maybe it should just never ask for it then as a required functionality!

Userspace may not have a useful decision-making capability regarding
functionality versus power-saving, but the user it's talking to might!

I think it would be very useful to have a mechanism for userspace to
find out "Link detection on this NIC costs ~50mW" and "No link has
been detected for the last 15 minutes", so that it can compile all
that sort of information and prompt the user what devices they would
like to disable.  Perhaps an "airline mode" sort of thing?

Cheers,
Kyle Moffett
