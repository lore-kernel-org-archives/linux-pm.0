From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2 1/2] Input: gpio-keys - allow platform to
 specify exact irq flags
Date: Mon, 30 Nov 2009 16:59:41 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0911301658240.4478-100000__30064.142184756$1259618507$gmane$org@iolanthe.rowland.org>
References: <87aay3losp.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87aay3losp.fsf@tac.ki.iif.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: linux-pm@lists.linux-foundation.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 30 Nov 2009, Ferenc Wagner wrote:

> > Just out of curiosity, how do you decide when the input should be 
> > muted and unmuted?
> 
> That's application logic.  For example, the user touches the "Lock"
> button, then slips the gadget into his pocket.  Then most other buttons
> (like volume control) are muted until the device is unlocked again by
> some very specific action.  My mobile phone doesn't work like this, it
> reacts to each button even when it's locked (though of course does
> nothing but says how to unlock it).

Okay.  This wasn't clear to me before.

> Well, I thought runtime PM is intended to have some "common sense"
> semantics, so it can be automatic.  After all, it's perfectly reasonable
> for somebody else to want the "normal" runtime PM for gpio-keys: to
> autosuspend when not in use.  If we stole the callbacks for our purpose,
> the "expected" behaviour couldn't be implemented later.  In other words,
> the wanted behaviour is not device specific, but usage specific.  And
> the runtime suspend behaviour of a device can't be usage specific, it
> should match common expectations (to the extent it's possible to talk
> about common expectations wrt. runtime PM -- but you may still want to
> build one up).  Are these fears unfounded?  Is runtime PM not what I
> think it is?

No, you are right.  Runtime PM is not well suited for this purpose.

Alan Stern
