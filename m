From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: intel_pstate divide error with v3.13-rc4-256-gb7000ad
Date: Sat, 04 Jan 2014 09:35:58 +0100
Message-ID: <52C7C7EE.1070407@redhat.com>
References: <CA+5PVA6YpKc6kYK5UiTnGLZpB8uts=-QPtyhotAyZ2kuoG8PPQ@mail.gmail.com> <52C6F3B4.3050904@gmail.com> <20140103180435.GK10961@minantech.com> <2513222.AheLcigoE8@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <2513222.AheLcigoE8@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Gleb Natapov <gleb@kernel.org>, Dirk Brandewie <dirk.brandewie@gmail.com>, Kashyap Chamarthy <kchamart@redhat.com>, Josh Boyer <jwboyer@fedoraproject.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, "Richard W.M. Jones" <rjones@redhat.com>
List-Id: linux-pm@vger.kernel.org

Il 03/01/2014 23:46, Rafael J. Wysocki ha scritto:
> Well, fixing the KVM bug is surely welcome.
> 
> That said, adding checks to ensure that your assumptions are valid is rarely
> wrong, especially if they are done once per kernel boot.  And the kernel only
> should panic if it cannot continue to run, which isn't the case here.

I agree, but I suspect even your check is already late.  Your patch is
welcome but perhaps it should have a WARN_ON too.

Paolo
