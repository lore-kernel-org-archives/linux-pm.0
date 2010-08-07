From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Sat, 7 Aug 2010 03:23:32 -0700
Message-ID: <AANLkTim-a6qHL_Xo+iVUW4p79EMMRssa0-AqZenNSYJr__44433.0761362382$1281183254$gmane$org@mail.gmail.com>
References: <AANLkTinQD3ggLFVd2KvX95U2B_j=ZJquZgiBGieukJ+r@mail.gmail.com>
	<Pine.LNX.4.44L0.1008061505070.9303-100000@netrider.rowland.org>
	<AANLkTinS_UyhRNMnViK_4aA4ve3thHhLthC+OM7cUMZc@mail.gmail.com>
	<201008071044.37486.rjw@sisk.pl>
	<AANLkTinebiC=9Xd-D_sOwmvA8w_YPWMdhTYz2NRbZ7jH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTinebiC=9Xd-D_sOwmvA8w_YPWMdhTYz2NRbZ7jH@mail.gmail.com>
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
Cc: david@lang.hm, peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

2010/8/7 Arve Hj=F8nnev=E5g <arve@android.com>:
> 2010/8/7 Rafael J. Wysocki <rjw@sisk.pl>:
>> On Saturday, August 07, 2010, Arve Hj=F8nnev=E5g wrote:
>>> 2010/8/6 Alan Stern <stern@rowland.harvard.edu>:
>>> > On Thu, 5 Aug 2010, Arve Hj=F8nnev=E5g wrote:
...
>>> >> total_time, total time the wake lock has been active. This one should
>>> >> be obvious.
>>> >
>>> > Also easily added.
>>> >
>>> Only with a handle passed to all the calls.
>>
>> Well, I'm kind of tired of this "my solution is the only acceptable one"
>> mindset. =A0IMHO, it's totally counter productive.
>>
>
> How do you propose to track how long a driver has blocked suspend when
> you have an unblock call that takes no arguments.
>

Also, I did not not see a response to my question about why you don't
want to pass a handle.

-- =

Arve Hj=F8nnev=E5g
