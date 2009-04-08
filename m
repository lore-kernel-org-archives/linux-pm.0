From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [RFC Disable suspend on a specific device] This is	a
	little change in linux power scheme
Date: Wed, 8 Apr 2009 12:42:13 +0100
Message-ID: <20090408114212.GK20122@sirena.org.uk>
References: <200904072257.23756.rjw@sisk.pl> <200904081013.25301.rjw@sisk.pl>
	<49DC5F58.7070705@gandalf.sssup.it>
	<200904081034.56624.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200904081034.56624.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 08, 2009 at 10:34:56AM +0200, Rafael J. Wysocki wrote:

> I think this is a rather fundamental issue and it requires some more thought.

> What platform is your device based on, BTW?

FWIW this is an issue for a very large proportion of modern mobile phone
platforms - when on a call they can often suspend the bulk of the system
while leaving the audio path used for the call alive (normally some
combination of the telephony modem, audio CODEC and bluetooth chipset)
and wake up if the user presses a button or similar.
