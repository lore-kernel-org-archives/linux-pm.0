From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFD] Automatic suspend
Date: Mon, 16 Feb 2009 12:28:30 -0800
Message-ID: <20090216122830.4096c5b0__23817.7237603397$1234816277$gmane$org@infradead.org>
References: <200902160010.16955.rjw@sisk.pl>
	<200902160806.17901.oliver@neukum.org>
	<20090216074048.6d70f17c@infradead.org>
	<200902161748.09208.oliver@neukum.org>
	<20090216093108.078aac35@infradead.org>
	<f73f7ab80902161208h12837d4ex1d28d55d031d5d71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <f73f7ab80902161208h12837d4ex1d28d55d031d5d71@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kyle Moffett <kyle@moffetthome.net>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, mark@smtp1.linux-foundation.org, Brian@smtp1.linux-foundation.org, Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 16 Feb 2009 15:08:09 -0500
Kyle Moffett <kyle@moffetthome.net> wrote:

> I think it would be very useful to have a mechanism for userspace to
> find out "Link detection on this NIC costs ~50mW" and "No link has
> been detected for the last 15 minutes", so that it can compile all
> that sort of information and prompt the user what devices they would
> like to disable.  Perhaps an "airline mode" sort of thing

modes suck... they're very much the wrong concept for power management
(but that's a different story)

if the user (or something on its behalf) doesn't need link detection,
he can turn it off. Really. He doesn't need to know that maybe on
machine one this saves some power, and on machine two that power was
already mostly saved while on machine three it doesn't save anything at
all. Not to mention that the driver is extremely unlikely to know how
much actual power will be saved...
 



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
