From: "Vitaly Wool" <vitalywool@gmail.com>
Subject: Re: [linux-pm] [PATCH] PowerOP, PowerOP Core, 1/2
Date: Sat, 23 Sep 2006 01:18:17 +0400
Message-ID: <acd2a5930609221418n7fd1251do636f56828a275505@mail.gmail.com>
References: <200609222028.k8MKSN5h008476@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932163AbWIVVST@vger.kernel.org>
In-Reply-To: <200609222028.k8MKSN5h008476@olwen.urbana.css.mot.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Scott E. Preece" <preece@motorola.com>
Cc: pavel@ucw.cz, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 9/23/06, Scott E. Preece <preece@motorola.com> wrote:
>
> I've been hoping somebody would send a good description of exactly what
> they mean by "power domain" or "voltage domain", so we could talk about
> it...

I understand it as an arbitrary set of devices grouped according to a
certain rule. An operating point will then deal with set of power
domains not with set of devices.

Vitaly
