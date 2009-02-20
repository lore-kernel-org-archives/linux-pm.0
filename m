From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFD] Automatic suspend
Date: Thu, 19 Feb 2009 18:39:29 -0800
Message-ID: <d6200be20902191839w1f74a962h30e859c8b2434f59__29587.1312650435$1235097722$gmane$org@mail.gmail.com>
References: <200902192215.18365.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0902191659020.7953-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0902191659020.7953-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 19, 2009 at 2:08 PM, Alan Stern <stern@rowland.harvard.edu> wro=
te:
>> > It might have to be platform-specific.  The Android people seem to hav=
e a
>> > pretty good idea of what criteria will work for them.
>>
>> I'd really like to know in what situations Androind is supposed to suspe=
nd
>> automatically.
>
> It might be better to ask in what situations Android is _not_ supposed
> to sleep automatically.  In other words, in what situations is a
> wakelock acquired?  Since the whole system is only a phone, this
> question should have a reasonably well-defined answer.

On an android phone, any code that needs to run when the screen is off
must hold a wakelock (directly or indirectly). In general if an
application or the system is processing an event that may cause a user
notification (new email, incoming phone call, alarm, etc.) it needs to
prevent suspend. But, we also use wakelocks to upload stats or
download system updates in the background, and for media player or
(gps) data logging applications.

-- =

Arve Hj=F8nnev=E5g
