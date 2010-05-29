From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Sun, 30 May 2010 09:00:05 +1000
Message-ID: <4C019C75.6020000__32235.1186922335$1275174079$gmane$org@crca.org.au>
References: <20100529131810.5bb51bdd@schatten.dmk.lab>	<Pine.LNX.4.44L0.1005290941060.30763-100000@netrider.rowland.org>
	<AANLkTik_4ezDAQoAQjkpEgwD9SLKeOjDzy2H7T2v6uCP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTik_4ezDAQoAQjkpEgwD9SLKeOjDzy2H7T2v6uCP@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Ingo Molnar <mingo@elte.hu>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

Hi.

I like the sound of this much better too, but...

On 30/05/10 08:13, Arve Hj=F8nnev=E5g wrote:
> On Sat, May 29, 2010 at 7:10 AM, Alan Stern<stern@rowland.harvard.edu>  w=
rote:
>> There is no /sys/power/policy file.  In place of opportunistic suspend,
>> we have "QoS-based suspend".  This is initiated by userspace writing
>> "qos" to /sys/power/state, and it is very much like suspend-to-RAM.
>
> Why do you want to tie it to a specific state?

I do agree here. I would suggest that all /sys/power/state possibilities =

should have a qos- equivalent. You might not want to use any or all of =

them, but they should be available.

Regards,

Nigel
