From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 11/13] PM: earlysuspend: Removing dependence
	on console.
Date: Thu, 5 Feb 2009 01:42:45 -0800
Message-ID: <d6200be20902050142p8924340mdc00100293b4dda@mail.gmail.com>
References: <1233802226-23386-3-git-send-email-arve@android.com>
	<1233802226-23386-5-git-send-email-arve@android.com>
	<1233802226-23386-6-git-send-email-arve@android.com>
	<1233802226-23386-7-git-send-email-arve@android.com>
	<1233802226-23386-8-git-send-email-arve@android.com>
	<1233802226-23386-9-git-send-email-arve@android.com>
	<1233802226-23386-10-git-send-email-arve@android.com>
	<1233802226-23386-11-git-send-email-arve@android.com>
	<1233802226-23386-12-git-send-email-arve@android.com>
	<20090205090621.GE2077@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090205090621.GE2077@elf.ucw.cz>
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
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, Rebecca Schultz <rschultz@google.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 5, 2009 at 1:06 AM, Pavel Machek <pavel@ucw.cz> wrote:
> You have just introduced another method of console switching in
> previous patch. Please drop pieces of duplicate functionality you are
> not using any more.

If console support is enabled use a console switch, if not use this.

>> +               Register early suspend handler that notifies and waits f=
or
>> +               user-space through sysfs when user-space should stop dra=
wing
>> +               to the screen and notifies user-space when it should res=
ume.
>>  endchoice
>
> Hmm, as far as I can tell, turning this option on will immediately
> break suspend on all existing setups. Bad.

I'm not aware of any existing interface that works if console support
is not enabled.

-- =

Arve Hj=F8nnev=E5g
