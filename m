From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [RFC 09/15] PM / Hibernate: user,
 implement	user_ops writer
Date: Thu, 01 Apr 2010 08:01:23 +1100
Message-ID: <4BB3B823.5080803@crca.org.au>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<201003300009.18315.rjw@sisk.pl> <4BB1508E.9030103@crca.org.au>
	<201003302303.12758.rjw@sisk.pl> <4BB2B3E5.7020708@crca.org.au>
	<20100331144702.GC3449@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100331144702.GC3449@ucw.cz>
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
Cc: linux-pm@lists.linux-foundation.org, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi.

On 01/04/10 01:47, Pavel Machek wrote:
> Hi!
>
>> Regarding using LRU pages as temporary storage, if it wasn't safe and
>> reliable, I would have stopped doing it ages ago. The only problem I can
>
> What kind of argument is that?
>
> And what prevents people from introducing more KMS-like breakage in
> future?

Nothing. And we catch it when it occurs and resave the pages. It is of 
course also possible for us to take a more complicated approach and save 
just what we know is safe.

Or we could just use kexec...

Nigel
