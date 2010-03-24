From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH v2] pcmcia: db1xxx-ss: suspend/resume fix
Date: Wed, 24 Mar 2010 18:04:50 +0100
Message-ID: <f861ec6f1003241004r629f0b35webd9d1925fe5f0d9__32223.8159169958$1269450406$gmane$org@mail.gmail.com>
References: <1269287003-15523-1-git-send-email-manuel.lauss@gmail.com>
	<20100322205814.GB15250@isilmar.linta.de>
	<f861ec6f1003231015j73d6de9dp7a3a4e087aabda0a@mail.gmail.com>
	<201003232302.49415.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003232302.49415.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pm@lists.linux-foundation.org, linux-pcmcia@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Dominik,

On Tue, Mar 23, 2010 at 11:02 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday 23 March 2010, Manuel Lauss wrote:
>> Howdy,
>>
>> On Mon, Mar 22, 2010 at 9:58 PM, Dominik Brodowski
>> <linux@dominikbrodowski.net> wrote:
>> > Hm, what about using two commits currently in my tree for 2.6.36 inste=
ad,
>> > which should fix all socket drivers?
>> >
>> > =A0 =A0power: support _noirq actions on device types and classes
>> > =A0 =A0pcmcia: use dev_pm_ops for class pcmcia_socket_class
>> >
>> > Manuel: Could you try whether they also solve these issues? If so, I'd
>>
>> Yes it does, works on my MIPS test systems.
>
> I don't seem to have received the original message, so sorry for the lack=
 of
> response.
>
>> > propose pushing both patches already for 2.6.36. Rafael: do you concur?
>
> I do. =A0The patches look good and if they fix things for people right no=
w,
> that's a good reason to push them for .34.
>
>> I hope you meant 2.6.34
>
> I think Dominik meant .35 actually.

Okay, can we apply my v2 patch to 2.6.34?  I'd like to have PM working when
it gets out.

Manuel
