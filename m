From: Ben Gamari <bgamari@gmail.com>
Subject: Re: Experimental power saving profile support branch in
	pm-utils
Date: Sat, 26 Jun 2010 01:08:29 -0400
Message-ID: <87sk4a1iuq.fsf@gmail.com>
References: <AANLkTin4YfM8qqEAxzqa9J8KZYa2L12BcgK5BdkosMPh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pm-utils-bounces+gcfp-pm-utils=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <AANLkTin4YfM8qqEAxzqa9J8KZYa2L12BcgK5BdkosMPh@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pm-utils>,
	<mailto:pm-utils-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pm-utils>
List-Post: <mailto:pm-utils@lists.freedesktop.org>
List-Help: <mailto:pm-utils-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pm-utils>,
	<mailto:pm-utils-request@lists.freedesktop.org?subject=subscribe>
Sender: pm-utils-bounces+gcfp-pm-utils=m.gmane.org@lists.freedesktop.org
Errors-To: pm-utils-bounces+gcfp-pm-utils=m.gmane.org@lists.freedesktop.org
To: Victor Lowther <victor.lowther@gmail.com>, pm-utils <pm-utils@lists.freedesktop.org>, devkit-devel@lists.freedesktop.org, Linux Power Management List <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 25 Jun 2010 23:44:22 -0500, Victor Lowther <victor.lowther@gmail.com> wrote:
> The latest release of pm-utils (1.4.0) added some default hooks for
> helping conserve power.  Based on the recent thread on linux-pm
> proposing a /sys/power/policy_preference knob, I decided to implement
> support for setting powersave profiles in pm-utils.  From the git
> logs:
> 
I'm really confused. This seems like the polar opposite of the direction
we have been saying we should be taking. The argument has been strongly
made (Matthew Garrett comes to mind, but there are no doubt others) in
the past that the concept of a power profile is fundamentally
broken. Instead we should _always_ be trying to save power. Thankfully
there are only very few cases where saving power and delivering good
performance are at stake. In general, the faster we can get our work
done, the longer we can remain in low-power states.  Moreover, hardware
is only getting better at saving power while minimally affecting
operation.

Thus, I pose the question: do we really want this sort of explicit
control in the user-space? Even if we do, I far from convinced that the
policy_preference model is a sound way to expose this preference to the
user. The 5 levels as layed out in the proposal seem awfully arbitrary
and really don't express the full gamut of preferences that a user might
hold.

- Ben
