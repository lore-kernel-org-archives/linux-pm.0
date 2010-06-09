From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: suspend blockers & Android integration
Date: Wed, 9 Jun 2010 10:43:58 +0300
Message-ID: <AANLkTino9hnqao9402dR543MIlf66qYYjxrknHrxd39o__45533.7533298463$1276069504$gmane$org@mail.gmail.com>
References: <20100603193045.GA7188@elte.hu>
	<AANLkTinQyzzeF-NOAjrAqqQXqKjFJhx85nI4uyBGRtWd@mail.gmail.com>
	<1275653210.27810.39762.camel@twins>
	<AANLkTinyjBa0KYfFz3_EFbC65hoQFwFINlTDYjCe-wM3@mail.gmail.com>
	<1275731653.27810.41078.camel@twins>
	<20100605092851.6ee15f13@infradead.org>
	<AANLkTimEwznq9c_8lkuBMxEQ-42rdvpZEqA9Y71Cu-qC@mail.gmail.com>
	<AANLkTimKknOurmCffOpHjc1FjrP2MKf10pBwEEbLJPg_@mail.gmail.com>
	<AANLkTil1NCX91bWhpXHtC88Opr29mNjdhXD9RXQ6DI0y@mail.gmail.com>
	<AANLkTin1Za3GvfIKbcZdx6TzjIHzCvsg5uaY_Vk4nJIh@mail.gmail.com>
	<AANLkTilQ1k78dDCYadOa1Wiyjm2nsBcRpxwdpGvYcf8z@mail.gmail.com>
	<AANLkTin7oM3gVwHbIHWqYV8yeC6bbQ4q2jDDxAgz3DwQ@mail.gmail.com>
	<alpine.DEB.2.01.1006060305060.17462@asgard.lang.hm>
	<AANLkTinW-X5m85rUcqP-lrEdfBikVclJWgqiWDkpxnAc@mail.gmail.com>
	<20100606124949.539fa636@schatten.dmk.lab>
	<alpine.DEB.2.01.1006060410050.17462@asgard.lang.hm>
	<20100607141624.3d004db2@schatten.dmk.lab>
	<alpine.DEB.2.01.1006081759150.17462@asgard.lang.hm>
	<alpine.LFD.2.00.1006082042020.4506@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1006082042020.4506@i5.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: david@lang.hm, Neil Brown <neilb@suse.de>, tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 9, 2010 at 6:46 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, 8 Jun 2010, david@lang.hm wrote:
>>
>> having suspend blockers inside the kernel adds significant complexity, it's
>> worth it only if the complexity buys you enough. In this case the question is
>> if the suspend blockers would extend the sleep time enough more to matter. As
>> per my other e-mail, this is an area with rapidly diminishing returns as the
>> sleep times get longer.
>
> Well, the counter-argument that nobody seems to have brought up is that
> suspend blockers exist, are real code, and end up being shipped in a lot
> of machines.
>
> That's a _big_ argument in favour of them. Certainly much bigger than
> arguing against them based on some complexity-arguments for an alternative
> that hasn't seen any testing at all.
>
> IOW, I would seriously hope that this discussion was more about real code
> that _exists_ and does what people need. It seems to have degenerated into
> something else.
>
> Because in the end, "code talks, bullshit walks". People can complain and
> suggest alternatives all they want, but you can't just argue. At some
> point you need to show the code that actually solves the problem.

That's assuming there is an actual problem, which according to all the
embedded people except android, there is not.

And if there is indeed such a problem (probably not big), it might be
solved properly by the time suspend blockers are merged, or few
releases after.

Whatever the solution (or workaround) is, it would be nice if it could
be used by more than just android people, and it would also be nice to
do it without introducing user-space API that *nobody* likes and might
be quickly deprecated.

-- 
Felipe Contreras
