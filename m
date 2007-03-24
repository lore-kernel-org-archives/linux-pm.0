From: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Subject: charging batteries from USB [was: Re: Alternative
	Concept]
Date: Sat, 24 Mar 2007 03:47:34 +0300
Message-ID: <46047526.5020707@gmail.com>
References: <44ECFF94.3030506@gmail.com>
	<200703200107.17290.david-b@pacbell.net>
	<45FFAD39.1000302@gmail.com>
	<200703201258.03926.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703201258.03926.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

David Brownell wrote:
>> For example, in USB you are able to enable/disable autosuspend rule,
>> don't know if it's possible to disable it at runtime though.
>
> There are patches to allow disabling it at runtime through sysfs
> attributes of any given device.
>
> The primary reason to have one is bugs in those external devices,
> where they don't behave according to the USB spec.  That's the

If I didn't miss something, the primary reason was to allow
devices to charge batteries from the bus, so, does USB
specs restrict this somehow? Or, what's wrong with that?


Thanks,
Dmitry
