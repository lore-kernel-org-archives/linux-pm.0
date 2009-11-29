From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Question on USB re-enumeration
Date: Sun, 29 Nov 2009 10:53:57 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0911291045220.3165-100000@netrider.rowland.org>
References: <8bf247760911290106k34958e48x2feec3007bd62f86@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <8bf247760911290106k34958e48x2feec3007bd62f86@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Sriram V <vshrirama@gmail.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 29 Nov 2009, Sriram V wrote:

> Hi,
>  We are not resetting the GSM device at all either during normal suspend-resume
>  or during a call. GSM device is always active
> 
>  We an  trans-reciever 1504 in between the GSM device and the
>  Host controller.
> 
> We just reset the trans-reciever in resume.

Maybe that is a mistake.

> During a call:
> 
> 1) I tried to put transreciever in reset in suspend and bring it out
> of reset in resume
> 
> I also tried:
> 
> 1) I tried to put it in reset and bring it out of reset in resume.
> 
> But both dont work. The D+ and D- is connected to GSM.
> 
> GSM (when a call is being made) sends some data over D+ and D-.
> 
> it is probable if  it does not accept some commands/transactions
> over D+ and D-.
> 
> Am not sure what happens when a transreciever is reset - If USB host
> sends some commands over USB in with is again sent to "GSM" during reset
> 
> Is resetting a transreciver same as - resetting a USB device?

I don't know.

> Am not really sure.
> 
> In this case is there anything i need to do make suspend-resume work
> always (when in a call)

Well, since it doesn't work now, you need to do _something_.  But I
don't know what.

Alan Stern
