From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH v3 1/2] Input: enable i8042-level wakeup
	control
Date: Thu, 28 Jul 2011 15:59:32 +0100
Message-ID: <CAGq3pz6vr2gOq91Cz6KByhF4vdWEZqOOWECZhOCVD38kcyuEFQ__24570.9851420999$1311865221$gmane$org@mail.gmail.com>
References: <20110728143121.E57469D401C@zog.reactivated.net>
	<Pine.LNX.4.44L0.1107281051220.1990-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1107281051220.1990-100000@iolanthe.rowland.org>
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
Cc: dtor@mail.ru, linux-pm@lists.linux-foundation.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, dilinger@queued.net
List-Id: linux-pm@vger.kernel.org

On 28 July 2011 15:53, Alan Stern <stern@rowland.harvard.edu> wrote:
> Shouldn't this also check device_may_wakeup(dev)? =A0The user might
> disable wakeup for the input device while leaving it enabled for the
> i8042 device.

As far as I'm aware, there aren't any instances where input devices
are marked as wakeup-capable. So, we're speaking theoretically.

But, what would this mean? On OLPC for example, we can only control
i8042 wakeups. This means we don't get to choose that we want keyboard
wakeups and not mouse. If you enable i8042 wakeups you get both, and
we can't change that, as the wakeup mechanism revolves around the
i8042 controller.

Daniel
