From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 05/13] PM: Add option to disable
	/sys/power/state interface
Date: Sun, 8 Feb 2009 15:00:38 -0800
Message-ID: <d6200be20902081500u29f349e4o797aad8cfddc60f9@mail.gmail.com>
References: <20090208210401.GE6369@elf.ucw.cz>
	<Pine.LNX.4.44L0.0902081628340.22400-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0902081628340.22400-100000@netrider.rowland.org>
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
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, Feb 8, 2009 at 1:40 PM, Alan Stern <stern@rowland.harvard.edu> wrot=
e:
> On Sun, 8 Feb 2009, Pavel Machek wrote:
>
>> Well, it is true that wakelocks could be single atomic_t ... but they
>> would make them undebuggable. Ok, wakelock interface sucks. But I
>> believe something like that is neccessary.
>
> krefs don't have name strings for keeping track of who has been
> incrementing or decrementing their counters.  And it's true that krefs
> are nearly undebuggable.  But somehow we've managed to struggle along
> without adding names to krefs.  Why should wakelocks be any different?

It sounds like you suggesting that we add another nearly undebuggable inter=
face.

Using only a single atomic_t would not allow us to use a wakelock a
switch, or to specify a timeout. You could replace the list in the
implementation with a single atomic_t by adding more state to each
wakelock, but I like my current solution better.

-- =

Arve Hj=F8nnev=E5g
