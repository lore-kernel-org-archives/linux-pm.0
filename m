From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 3/5] cpuidle:powernv: Add helper function to populate
 powernv idle states.
Date: Mon, 30 Jan 2017 08:12:09 +0100
Message-ID: <CAJZ5v0j_vzsaNeYNBmKs3oMnXyVHF_3chRjeTEwQA_k0TDc3Nw@mail.gmail.com>
References: <1485333389-5752-1-git-send-email-ego@linux.vnet.ibm.com>
 <1485333389-5752-4-git-send-email-ego@linux.vnet.ibm.com> <871svlxl7w.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <871svlxl7w.fsf-W0DJWXSxmBNbyGPkN3NxC2scP1bn1w/D@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>
Cc: "Gautham R. Shenoy" <ego-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Michael Neuling <mikey-/owAOxkjmzZAfugRpC6u6w@public.gmane.org>, Vaidyanathan Srinivasan <svaidy-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "Shreyas B. Prabhu" <shreyasbp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shilpasri G Bhat <shilpa.bhat-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Stewart Smith <stewart-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Balbir Singh <bsingharora-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Oliver O'Halloran <oohall-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linuxppc-dev <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mar
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 30, 2017 at 4:47 AM, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org> wrote:
> "Gautham R. Shenoy" <ego-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org> writes:
>
>> From: "Gautham R. Shenoy" <ego-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
>>
>> In the current code for powernv_add_idle_states, there is a lot of code
>> duplication while initializing an idle state in powernv_states table.
>>
>> Add an inline helper function to populate the powernv_states[] table
>> for a given idle state. Invoke this for populating the "Nap",
>> "Fastsleep" and the stop states in powernv_add_idle_states.
>>
>> Acked-by: Balbir Singh <bsingharora-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Gautham R. Shenoy <ego-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
>> ---
>>  drivers/cpuidle/cpuidle-powernv.c | 89 +++++++++++++++++++++++----------------
>>  include/linux/cpuidle.h           |  1 +
>
> I was going to merge this, but I see you've touched cpuidle.h, so I feel
> like I should get an ACK from the cpuidle folks.
>
> It's a fairly uncontroversial change, but it's their API.

OK, please add an ACK from me to it then.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
