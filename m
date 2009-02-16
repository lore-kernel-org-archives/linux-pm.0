From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFD] Automatic suspend
Date: Mon, 16 Feb 2009 09:31:08 -0800
Message-ID: <20090216093108.078aac35__688.069666694169$1234805707$gmane$org@infradead.org>
References: <200902160010.16955.rjw@sisk.pl>
	<200902160806.17901.oliver@neukum.org>
	<20090216074048.6d70f17c@infradead.org>
	<200902161748.09208.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902161748.09208.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Matthew@smtp1.linux-foundation.org, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 16 Feb 2009 17:48:06 +0100
Oliver Neukum <oliver@neukum.org> wrote:

> > Userspace should just be the part that says "I'm interested in link
> > notifications". The driver then just goes to the lowest power state
> > for its device that still gives those notifications.
> 
> Should there be a channel through which drivers can tell user space
> what the consequences in terms of reaching a sleep state are if a
> service is requested?

Personally, I don't think so.
Think about it: what would userspace do?
Not ask for the functionality if it means no sleep state?
Maybe it should just never ask for it then as a required functionality!



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
