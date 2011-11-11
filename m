From: Nigel Cunningham <nigel@tuxonice.net>
Subject: Re: Question regarding kjournald when entering
	hibernation
Date: Sat, 12 Nov 2011 08:36:59 +1100
Message-ID: <4EBD957B.20309@tuxonice.net>
References: <CACzi5T9Df+h4eG_yabUt4sU5V=W+6gvVWODk90FzkX1jH=BhUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CACzi5T9Df+h4eG_yabUt4sU5V=W+6gvVWODk90FzkX1jH=BhUw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mohan <camilo.id@gmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi Mohan.

On 11/11/11 19:35, Mohan wrote:
> Hi,
> 
> I am testing hibernation on a PPC4xx board.
> I have noticed that kjournald is still running even when the hibernation
> image is being saved to disk.
> 
> On looking at the code in fs/jbd/journal.c the kjournald thread
> has a check "if(freezing(current))" which i assume is to
> check if hibernating and to freeze the kjournald thread.
> But since the kjournald thread has the PF_NOFREEZE flag
> set it does not freeze the kjournald thread.
> 
> 1. Can any one tell me in what case the kjournald thread is frozen?

All kernel threads were originally treated as unfreezable. Looking at
the history of kjournald in git, the support for freezing kjournald has
been there since before 2.6.12-rc2 (before git began to be used). I'd
therefore say that the code may never have been used and kjournald may
never have been frozen.

> 2. Or is there no problem if it is not frozen during hibernation ?

Since the hibernation code seeks to make an atomic copy which is then
saved, there shouldn't be a problem in the case of the vanilla kernel
and uswsusp. TuxOnIce might possibly have a problem if kjournald had
work to do and tried to do it (though a BUG_ON that the patch adds in
the block would capture the attempt at submitting I/O and stop
corruption occuring).

> 3. Would it be a bad idea to set the kjournald thread freezeable using
> "set_freezable()" ?

I think it would be a good idea. Even with the atomic copy (ignoring ToI
since it's out-of-tree), it will simplify the debugging process if
things that shouldn't be running don't run during hibernation.

Regards,

Nigel
-- 
Evolution (n): A hypothetical process whereby improbable
events occur with alarming frequency, order arises from chaos, and
no one is given credit.
