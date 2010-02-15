From: Andrew Lutomirski <luto@mit.edu>
Subject: Re: iwlagn on Thinkpad X200
Date: Mon, 15 Feb 2010 09:55:58 -0500
Message-ID: <cb0375e11002150655t5d85f824i41a526522758970b@mail.gmail.com>
References: <20100215134823.GA2864@qi> <4B79538F.4090501@mit.edu>
	<20100215143137.GA4789@qi>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100215143137.GA4789@qi>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthias-Christian Ott <ott@mirix.org>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 15, 2010 at 9:31 AM, Matthias-Christian Ott <ott@mirix.org> wro=
te:
> On Mon, Feb 15, 2010 at 09:00:47AM -0500, Andy Lutomirski wrote:
>> Looks mostly reasonable to me. =A0Did you try 'iwconfig wlan0 power on'?
>
> Yes, it didn't make an improvement.
>
>> If you're feeling adventurous, try iwlcore.no_sleep_autoadjust=3D0 and
>> 'iwconfig wlan0 power on'. =A0The combination works for me and
>> decreases power consumption a lot at the cost of a little bit of
>> latency.
>
> It worked for me too, even if it just saved about 6 wake-ups per
> second.

Look at power, not wakeups, for wireless stuff -- powering up the
receiver isn't cheap.

>
> But I still wonder where the other parameters most users report about
> have gone.
>

Look in debugfs.  They've been renamed or removed in recent kernels.

--Andy
