From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH v4 1/2] Input: enable i8042-level wakeup
	control
Date: Sat, 3 Sep 2011 13:45:25 +0100
Message-ID: <CAMLZHHQ_ErVVg0TqVuaA=R0SbYdn=htMN+2rcTEEqaF-i9LC4w__46076.1989736513$1315054002$gmane$org@mail.gmail.com>
References: <20110802154916.624619D401C@zog.reactivated.net>
	<20110803065920.GC23399@core.coreip.homeip.net>
	<CAMLZHHTTXvThE5bWfyjJu-UFJbaKAhzORKWV8ay4RZW-ZVifLg@mail.gmail.com>
	<20110803184332.GA17880@core.coreip.homeip.net>
	<CAMLZHHTnTTbD7mn_QsjwyFZ=XU6paddrtXEVuLYossk9qBGFfw@mail.gmail.com>
	<CAMLZHHTie_u40NZ40o+LCwffk=3LbY96YTwxQt5wcVtbTc53qg@mail.gmail.com>
	<20110817070351.GE29361@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110817070351.GE29361@core.coreip.homeip.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, dilinger@queued.net, linux-input@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

Sorry for the delay in replying to this - I took sime time off.


On Wed, Aug 17, 2011 at 8:03 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> OK, so we have the following scenario:
>
> - we do not need to worry about SND and LED on OLPC;
>
> - we do not need to worry about releasing the key that was pressed
> =A0when we went to sleep because they system would not go to sleep while
> =A0there is a key pressed. So the code in input_dev_resume() won't
> =A0actually release any keys unless a key was held pressed and we forced
> =A0system to sleep somehow.
>
> - we need to make sure we do not loose key press (and following events)
> =A0when we are waking up.

Yes, that seems accurate, with one more addition:

- we need to make sure we do not loose mouse button press or mouse
movement (and following events) when we are waking up.

> Can atkbd driver stash away serio byte data (when not in command mode)
> and replay it when pm notifier signals us that resume process is done?

I'm having trouble understanding this suggestion or relating it to the
problems in question and the previous patches posted. Are you
suggesting stashing of data that is sent from the host  to the
keyboard, or from the keyboard to the host? How does this solve our
issues? What about the mouse?

How is it going to avoid the input-level issues?

Thanks,
Daniel
