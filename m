From: Amit Kachhap <amit.kachhap@linaro.org>
Subject: Re: [RFC PATCH 2/2] thermal: Add generic cpu cooling
	implementation
Date: Thu, 2 Feb 2012 14:46:31 +0530
Message-ID: <CAK44p23gUr=y4h_VUsy4_NWQvVRbG=EmLLXkZN3Lp-HnGsuPYQ@mail.gmail.com>
References: <1323789196-4942-1-git-send-email-amit.kachhap@linaro.org>
	<1323789196-4942-3-git-send-email-amit.kachhap@linaro.org>
	<20120201145707.GD30184@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120201145707.GD30184@srcf.ucam.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linaro-dev@lists.linaro.org, patches@linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 1 February 2012 20:27, Matthew Garrett <mjg@redhat.com> wrote:
> On Tue, Dec 13, 2011 at 08:43:16PM +0530, Amit Daniel Kachhap wrote:
>> This patch adds support for generic cpu thermal cooling low level
>> implementations using frequency scaling and cpuhotplugg currently.
>
> We've been over this kind of thing in the past. cpu hotplug is a
> relatively expensive operation, so people have previously been
> enthusiastic about using the scheduler to simply avoid running anything
> on CPUs if they're overheating. Has any general consensus been reached
> on this?
yes you are right that cpuhotplug is an expensive process and it may
further heat up the system before turning off so the ideal way would
be to reduce the capacity of the cpu gradually. Anyway these patches
are only exporting those API's and the actual use of them depends on
the user. Although my bigger focus is on cpufreq as cooling devices so
I might remove cpuhotplug in the next version.
>
> I'm also not entirely thrilled at now having two ways to manage the cpu
> through the thermal layer. ACPI already plugs in via the passive trip
> points. If we're going to do this then I'd like to see the ACPI code
> merged in with the generic cpu cooling code.
Yeah I also agree that there is a kind of repetition and not entirely
sure where to place these codes. I will try adding them inside acpi.
Thanks for the suggestion.
>
> --
> Matthew Garrett | mjg59@srcf.ucam.org
