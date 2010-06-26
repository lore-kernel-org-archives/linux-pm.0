From: Victor Lowther <victor.lowther@gmail.com>
Subject: Experimental power saving profile support branch in
	pm-utils
Date: Fri, 25 Jun 2010 23:44:22 -0500
Message-ID: <AANLkTin4YfM8qqEAxzqa9J8KZYa2L12BcgK5BdkosMPh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pm-utils-bounces+gcfp-pm-utils=m.gmane.org@lists.freedesktop.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pm-utils>,
	<mailto:pm-utils-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pm-utils>
List-Post: <mailto:pm-utils@lists.freedesktop.org>
List-Help: <mailto:pm-utils-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pm-utils>,
	<mailto:pm-utils-request@lists.freedesktop.org?subject=subscribe>
Sender: pm-utils-bounces+gcfp-pm-utils=m.gmane.org@lists.freedesktop.org
Errors-To: pm-utils-bounces+gcfp-pm-utils=m.gmane.org@lists.freedesktop.org
To: pm-utils <pm-utils@lists.freedesktop.org>, devkit-devel@lists.freedesktop.org, Linux Power Management List <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

The latest release of pm-utils (1.4.0) added some default hooks for
helping conserve power.  Based on the recent thread on linux-pm
proposing a /sys/power/policy_preference knob, I decided to implement
support for setting powersave profiles in pm-utils.  From the git
logs:

Add support for powersave policies.

    A powersave policy is a pm-utils configuration file that the pm-powersave
    command treats specially.  You can use it to define various levels of power
    savings available to a system by changing the environment variables the
    power.d hooks run with, and by blacklisting any hooks you do not want to
    use at any given level.

    pm-powersave will look in /etc/pm/powersave and /usr/lib/pm-utils/powersave
    in that order, and policy settings override any other variables or hook
    overrides set via other methods. If no policies are in use, pm-powersave
    considers itself to be in the default policy, and will fall back to the
    usual settings for the powersave hooks.

    You can set a powersave policy with

    pm-powersave --(ac|battery)-policy=<policy>

    or

    pm-powersave --(ac|battery)-policy <policy>

    Setting a policy in this fashion does not actually apply the policy.

    You can get the current powersave policy by running

    pm-powersave --(ac|battery)-policy

    You can list all the policies with

    pm-powersave --list-policies

    Policies should not know or care about the actual power source the system
    is using -- it is expected that some users will want to use the same policy
    no matter what power source is being used.

    The "default" policy is shorthand for the way pm-powersave will behave
    in the absence of a defined policy for either the ac or battery
power states.
    When on AC power, it will set everything back to the kernel defaults.
    On battery power, it will tune things according to the powersave
hook defaults.

    If you want to apply a powersave policy directly, just run

    pm-powersave <policyname>

    and the policy you passed will be immediatly applied without changing the
    preferred policy for the current power state.

You can get the branch that implements this from
http://cgit.freedesktop.org/pm-utils/ in the powersave-policies
branch.

If there is a power savings knob that we should handle but do not,
please either send a patch to the pm-utils mailing list or email me
directly.

If there are any ideas about setting good cross-distro defaults, I am
interested about them.

Regards,
   Victor Lowther
